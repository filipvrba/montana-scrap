module App
  module Files
    module_function

    def write(content, path, really = true, mode = 'w+')
      unless really
        return false
      end
      
      File.open path, mode do |f|
        f.write(content)
      end

      return true
    end
  end
end