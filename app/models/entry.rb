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
  field :parsed_content, type: String
  index user_id: 1

  before_save :parse_content

  #remove all blank [[]] in string
  #replace all [[example]] to <a href="entry">example</a> in string
  protected

  def parse_content
    self.parsed_content = self.content.
          gsub(/\[\[\]\]/, " ").
          #gsub(/\[\[(?<foo>[^\]\]])\]\]/, '<a class="entry-title">\k<foo></a>')
          gsub(/\[\[(?<foo>[^\]\]]+)\]\]/, '<a class="entry-title">\k<foo></a>')
  end


  def self.create_menu_with(user_id)
    self.create!({
      user_id: user_id,
      type: 'menu',
      title: '菜单',
      content: '[[菜单]]'
    })
  end

  def self.create_default_with(user_id)
    self.create!({
      user_id: user_id,
      type: 'default',
      title: '默认节点',
      content: '默认节点'
    })
  end

end
