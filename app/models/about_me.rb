class AboutMe

  attr_accessor :description

  def initialize
    File.open("config/about_me.txt", "r") do |f|
      @description = f.read
    end
    return self
  end

  def update(data)
    File.open("config/about_me.txt", "w+") do |f|
      f.write(data[:description])
    end
    @description = data[:description]
    return self
  end
end