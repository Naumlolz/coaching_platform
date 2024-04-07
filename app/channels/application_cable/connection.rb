module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_person

    def connect
      self.current_person = find_verified_person
    end

    private

    def find_verified_person
      person = cookies.encrypted["_coaching_platform_session"]['member_type']
      current_person = if person == 'User'
                         User.find_by(id: cookies.encrypted["_coaching_platform_session"]['member_id'])
                       elsif person == 'Coach'
                         Coach.find_by(id: cookies.encrypted["_coaching_platform_session"]['member_id'])
                       end
      if current_person.blank?
        reject_unauthorized_connection
      else
        current_person
      end
    end
  end
end
