class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  # Viewのこと -> helper
  def full_name
    "#{first_name} #{last_name}"
  end

  # UserにアソシエーションされているPostのこと
  def active_posts
    posts.where(status: 'active')
  end

  # UserにアソシエーションされているCommentのこと
  def recent_comments
    comments.where('created_at > ?', 1.week.ago)
  end

  # UserにアソシエーションされているPostとCommentのこと
  def calculate_activity_score
    posts.count * 10 + comments.count * 3 + likes.count
  end

  # Mailのこと
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  # privateメソッドでもOK？
  def generate_auth_token
    SecureRandom.hex(20)
  end

  # おそらくViewで使用する？
  def recent_activity_report
    {
      post_count: posts.where('created_at > ?', 1.month.ago).count,
      comment_count: comments.where('created_at > ?', 1.month.ago).count,
      like_count: likes.where('created_at > ?', 1.month.ago).count
    }
  end

  # さらに多くのメソッド...
end
