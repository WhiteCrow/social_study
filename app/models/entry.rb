class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Post

  validates_presence_of :title, :content
  validates_uniqueness_of :title
  field :title, type: String
  field :content, type: String

  before_save :parse_content

  def self.menu
    begin
      self.find_by(title: "菜单").content
    rescue
      nil
    end
  end

  def self.default_entry
    begin
      self.find_by(title: "默认词条").content
    rescue
      nil
    end
  end

  #remove all blank [[]] in string
  #replace all [[example]] to <a href="entry">example</a> in string
  def parse_content
    self.content = self.content.
          gsub(/\[\[\]\]/, " ").
          #gsub(/\[\[(?<foo>[^\]\]])\]\]/, '<a class="entry-title">\k<foo></a>')
          gsub(/\[\[(?<foo>[^\]\]]+)\]\]/, '<a class="entry-title">\k<foo></a>')
  end
end
