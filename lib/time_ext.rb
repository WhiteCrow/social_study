module TimeExt
  class Time
    def local
      self.getlocal.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
