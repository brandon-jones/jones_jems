class ContactMe

  attr_accessor :description

  def initialize
    File.open(file_path, "r") do |f|
      @description = f.read
    end
    return self
  end

  def update(data)
    File.open(file_path, "w+") do |f|
      f.write(data[:description])
    end
    @description = data[:description]
    return self
  end

  private

  def file_path
    return "config/contact_me.txt" if Rails.env == 'development'
    return ENV["APP_PATH"] + "/shared/config/contact_me.txt"
  end
end