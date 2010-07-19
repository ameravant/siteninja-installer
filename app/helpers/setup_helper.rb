module SetupHelper
  def get_git_directory(s)
    s.gsub(/\S*\/(\S*)(.git)/, '\1')
  end
end
