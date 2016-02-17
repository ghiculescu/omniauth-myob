require "omniauth/strategies/oauth2"

module OmniAuth
  module Strategies
    class Myob < OmniAuth::Strategies::OAuth2

      option :name, 'myob'

      option :client_options, {
        :site          => 'https://secure.myob.com',
        :authorize_url => '/oauth2/account/authorize',
        :token_url     => '/oauth2/v1/authorize',
      }

      option :authorize_params, {
        'scope' => 'CompanyFile'
      }

      uid { access_token['user']['uid'] }

      info do # http://myobapi.tumblr.com/post/90433459429/single-sign-on-with-myobapi
        {
          'uid' => access_token['user']['uid'],
          'email' => access_token['user']['username']
        }
      end

      private

      def headers
        @headers ||= {
          'x-myobapi-key'     => options.client_id,
          'x-myobapi-cftoken' => '',
          'x-myobapi-version' => 'v2',
        }
      end

    end
  end
end