module SES
  class Statistic

    def initialize
      @ses = AWS::SimpleEmailService.new access_key_id: AWS_CONFIG["access_key_id"], \
                                         secret_access_key: AWS_CONFIG["secret_access_key"]
    end

    def retrieve
      @ses.statistics
    end

  end
end
