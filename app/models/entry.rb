class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Post

  TYPES = ['default', 'menu']
  RESERVED_TITLES = ['默认条目', '菜单']
  PLACEHODER_CONTENT = "该条目为空，请点击右上方的<i class='icon-edit'><li>编辑条目"

  belongs_to :user

  validates_presence_of :title, :content, :user_id, :parsed_content
  validates_uniqueness_of :title, scope: :user_id
  validates_inclusion_of :type, in: TYPES, allow_nil: true
  validates_uniqueness_of :type, scope: :user_id, unless: Proc.new{|e| e.type.nil?}
  validates_exclusion_of :title, in: RESERVED_TITLES, if: Proc.new{|e| e.type.nil?}

  field :title, type: String
  field :type, type: String
  field :content, type: String
  field :parsed_content, type: String
  index user_id: 1

  before_validation :parse_content
  after_build :set_default_parsed_content

  #remove all blank [[]] in string
  #replace all [[example]] to <a href="entry">example</a> in string
  protected

  def parse_content
    self.parsed_content = self.content.
          gsub(/\[\[\]\]/, " ").
          #gsub(/\[\[(?<foo>[^\]\]]+)\]\]/, '<a href=\'/entries/next/\k<foo>\' class="entry-title" ng-click="next()">\k<foo></a>')
          gsub(/\[\[(?<foo>[^\]\]]+)\]\]/, '<a class="entry-title" ng-click="next(\'\k<foo>\')">\k<foo></a>').
          gsub(/\\\[\\\[\\\]\\\]/, '[[]]').
          gsub(/\\\[\\\[(?<foo>[^\]\]]+)\\\]\\\]/, '[[\k<foo>]]')
  end

  def set_default_parsed_content
    self.parsed_content = "这是一个空条目，如果拥有编辑权限，可以点击右上角的 <i class='icon-edit'></i> 进行编辑"
  end

  def self.create_menu_with(user_id)
    self.create!({
      user_id: user_id,
      type: 'menu',
      title: '菜单',
      content: '<ul class="nav nav-pills nav-stacked">
       <li>[[菜单]]</li>
       <li>[[默认条目]]</li>
       <li>[[日记]]</li>
      </ul>'
    })
  end

  def self.create_default_with(user_id)
    self.create!({
      user_id: user_id,
      type: 'default',
      title: '默认条目',
      content:"<p><b>使用说明：</b></p>
              <p>欢迎迎实用你的个人维基系统，
              你可以点击右上角的&nbsp;<i class='icon-edit'></i>编辑你的当前条目，
              右上角的&nbsp;<i class='icon-trash'></i>用于删除当前条目。</p>
              <br>
              <p>编辑时键入<b>“\\[\\[条目名\\]\\]”</b>
              来创建新条目或链接到已有条目。<b>“\\[\\[\\]\\]”</b>是一种特殊语法，
              它用于创建和链接条目。同时，[[菜单]]和[[日记]]也是一种条目，
              可以随时进行个性化编辑。</p>
              <p></p><p>更新[[菜单]]后刷新页面，
              可以看见你更新后的菜单内容。</p><p><br></p><p>点击左侧的
              “所有条目”，可以查看全部非空条目。
              <br></p><p></p><p><br></p><p>编辑时点击编辑器的右侧的
              <span class='icon-fullscreen'></i>，可以进入全屏编辑模式。
              <br>菜单和默认条目被删除后会自动还原到初始版本。
              "
    })
  end

end
