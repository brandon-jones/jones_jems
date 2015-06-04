class AboutMe

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
    puts "*"*800
    puts Dir.pwd
    return "config/about_me.txt" if Rails.env == 'development'
    return File.expand_path File.dirname(__FILE__) + "/shared/config/about_me.txt"
  end
end