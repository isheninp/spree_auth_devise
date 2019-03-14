module Spree
  class UserMailer < BaseMailer
    
    def reset_password_instructions(user, token, *_args)
      @edit_password_reset_url = spree.edit_spree_user_password_url(reset_password_token: token, host: Spree::Store.current.url)

      mail to: user.email, from: from_address, subject: Spree::Store.current.name + ' ' + I18n.t(:subject, scope: [:devise, :mailer, :reset_password_instructions])
    end

    def confirmation_instructions(user, token, _opts = {})
      @confirmation_url = spree.spree_user_confirmation_url(confirmation_token: token, host: Spree::Store.current.url)
      @email = user.email

      mail to: user.email, from: from_address, subject: Spree::Store.current.name + ' ' + I18n.t(:subject, scope: [:devise, :mailer, :confirmation_instructions])
    end
    
    def unlock_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :unlock_instructions, opts)
    end
    
    def devise_mail(record, action, opts = {}, &block)
      initialize_from_record(record)
      mail headers_for(action, opts), &block
    end
    
  end
end
