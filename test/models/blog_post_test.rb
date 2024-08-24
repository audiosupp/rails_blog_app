require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft? returns true for draft blog post" do
    assert blog_posts(:draft).draft?
  end

  test "draft? returns false for draft blog post" do
    assert_not blog_posts(:published).draft?
  end

  test "draft? returns false for scheduled blog post" do
    assert_not blog_posts(:scheduled).draft?
  end

  test "published? return true for published blog post" do
    assert BlogPost.new(published_at: 1.year.ago).published?
  end

  test "published? return false for draft blog post" do
    assert_not draft_blog_post.published?
  end

  test "published? return false for scheduled blog post" do
    assert_not BlogPost.new(published_at: 1.year.from_now).published?
  end

  test "scheduled? return true for scheduled blog post" do
    assert BlogPost.new(published_at: 1.year.from_now).scheduled?
  end

  test "scheduled? return false for draft blog post" do
    assert_not draft_blog_post.scheduled?
  end

  test "scheduled? return false for published blog post" do
    assert_not BlogPost.new(published_at: 1.year.ago).scheduled?
  end

  def draft_blog_post
    BlogPost.new(published_at: nil)
  end
end
