class Notice
  def initialize(notice)
    @notice = notice
    @notice.each { |k, v| instance_variable_set(:"@#{k}", v) }
  end

  def save
    return unless authorized?
    issue.occurences << occurence
    occurence
  end

  def authorized?
    app
  end

  def app
    @app ||= App.where(api_key: api_key).first
  end

  def issue
    @issue ||= app.issues.find_or_create_by!(fingerprint: fingerprint) do |issue|
      framework = @framework
      message = @message
      environment = @environment
      error_class = @error_class
      first_occurence_at = Time.now
    end
  end

  def occurence
    @occurence ||= Occurence.new(
      app_server: @app_server,
      environment_data: @environment_data,
      request_data: @request_data,
      notifier_data: @notifier_data,
      session_data: @session_data,
      additional_data: @additional_data
    )
  end

  private

    def fingerprint
      Fingerprint.generate(notice)
    end
end