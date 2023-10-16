module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_person

    def connect
      self.current_person = find_verified_person
    end

    private

    def find_verified_person
      person = request.params[:person]
      current_person = if person == 'user'
                         User.find_by(id: cookies.encrypted['session']['member_id'])
                       elsif person == 'coach'
                         Coach.find_by(id: cookies.encrypted['session']['member_id'])
                       end
      if current_person.blank?
        reject_unauthorized_connection
      else
        current_person
    end
  end
end
