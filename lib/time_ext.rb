# coding: utf-8
module TimeExt

  def local
    self.getlocal.strftime("%Y-%m-%d %H:%M:%S")
  end

  def time_ago
    time = (Time.now - self).to_i
    case time
      when 0..59
        '刚刚'
      when 60..3599
        (time/60).to_i.to_s+' 分钟前'
      when 3600..(3600*24-1)
        (time/3600).to_i.to_s+' 小时前'
      when (3600*24)..(3600*24*30)
        (time/(3600*24)).to_i.to_s+' 天前'
      else
        self.local
    end
  end

end
