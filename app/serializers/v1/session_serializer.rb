class V1::SessionSerializer < ActiveModel::Serializer
    attributes :email, :token_type, :user_id, :access_token, :host_code

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end
end
