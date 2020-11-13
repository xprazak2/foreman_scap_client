require 'foreman_scap_client/client_base'

module ForemanScapClient
  class Client < ClientBase
    attr_reader :tailored

    private

    def policy_namespace
      'ds'
    end

    # remove when we have made changes to puppet module/ansible role to start namespacing existing ds policies
    def policy_from_config
      super || @config[policy_id]
    end

    def ensure_policy_exists
      super
      @tailored = policy_from_config[:tailoring_path] && !policy_from_config[:tailoring_path].empty?
    end

    def ensure_scan_files
      ensure_scan_file
      ensure_tailoring_file if tailored
    end

    def scan_command
      if config[@policy_id] && config[@policy_id][:profile] && !config[@policy_id][:profile].empty?
        profile = "--profile #{config[@policy_id][:profile]}"
      else
        profile = ''
      end
      fetch_remote_resources = if config[:fetch_remote_resources]
                                 '--fetch-remote-resources'
                               else
                                 ''
                               end
      "oscap xccdf eval #{fetch_remote_resources} #{profile} #{tailoring_subcommand} --results-arf #{results_path} #{config[@policy_id][:content_path]}"
    end

    def tailoring_subcommand
      tailored ? "--tailoring-file #{config[policy_id][:tailoring_path]}" : ""
    end

    def upload_uri
      foreman_proxy_uri + "/compliance/arf/#{@policy_id}"
    end

    def ensure_scan_file
      ensure_file :content_path, :download_path, "SCAP content"
    end

    def ensure_tailoring_file
      ensure_file :tailoring_path, :tailoring_download_path, "Tailoring file"
    end
  end
end
