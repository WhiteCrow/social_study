class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Post

  TYPES = ['default', 'menu']
  RESERVED_TITLES = ['默认条目', '菜单']
  belongs_to :user

  validates_presence_of :title, :content, :user_id
  validates_uniqueness_of :title, scope: :user_id
  validates_inclusion_of :type, in: TYPES, allow_nil: true
  validates_uniqueness_of :type, scope: :user_id, unless: Proc.new{|e| e.type.nil?}
  validates_exclusion_of :title, in: RESERVED_TITLES, if: Proc.new{|e| e.type.nil?}

  field :title, type: String
  field :type, type: String
  field :content, type: String
  index user_id: 1

  before_save :parse_content

  def self.menu
    self.special_content_by("菜单")
  end

  def self.default_content
    self.special_content_by("默认词条")
  end

  def self.special_content_by(type)
    return nil if type.blank?
    begin
      self.find_by(type: type).content
    rescue
      #self.send "create_#{type}"
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

  protected
  def self.create_menu
    self.create({
      title: '菜单',
      cotent: '[[菜单]]'
    })
  end


end
