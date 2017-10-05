module ApplicationHelper

  def user_name(id)
    @user = User.find(id)
    return @user.email
  end

  def time_left(time)
    if time.present?
      task_time = time.to_i - Time.now.to_i
      if task_time > 86400
        task_time = task_time / 86400
        return "#{task_time} Day left"
      elsif task_time > 3600
        task_time = task_time / 3600
        return "#{task_time} Hours left"
      elsif task_time > 60
        task_time = task_time / 60
        return "{task_time} minutes left"
      else
        return "Expired"
      end

    end
  end


end
