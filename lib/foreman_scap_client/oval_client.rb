require 'foreman_scap_client/base_client'

module ForemanScapClient
  class OvalClient < BaseClient
    private

    def policy_namespace
      'oval'
    end

    def ensure_scan_files
      ensure_file :content_path, :download_path, "OVAL content"
    end

    def upload_uri
      foreman_proxy_uri + "/compliance/oval/#{@policy_id}"
    end

    def scan_command
      "oscap oval eval --results #{results_path} #{policy_from_config[:content_path]}"
    end
  end
end
