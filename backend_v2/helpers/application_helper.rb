# /helpers/application_helpers.rb

module ApplicationHelpers
    def generate_token(payload)
        # Agregar timestamp de expiración
        payload[:exp] = Time.now.to_i + settings.jwt_expiration
        
        JWT.encode(payload, settings.jwt_secret, 'HS256')
    end
    
    def decode_token(token)
        begin
            JWT.decode(token, settings.jwt_secret, true, { algorithm: 'HS256' })
        rescue JWT::DecodeError, JWT::ExpiredSignature
            nil
        end
    end
    
    def current_user
        return @current_user if defined?(@current_user)
        
        token = request.env['HTTP_AUTHORIZATION']&.gsub(/^Bearer /, '')
        return nil unless token
        
        decoded = decode_token(token)
        @current_user = decoded ? decoded[0] : nil
    end
    
    def protected!
        halt 401, { error: 'Token requerido' }.to_json unless current_user
    end
end