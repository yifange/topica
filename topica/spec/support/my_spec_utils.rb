module MySpecUtils
  def self.random_string(len)
    (0...len).map { (65 + rand(26)).chr }.join
  end
end

