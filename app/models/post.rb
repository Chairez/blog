# encoding: UTF-8
# Clase de modelo: Post
class Post < ActiveRecord::Base
  # attr_accessible :texto, :titulo
  validates :titulo, :presence => true,
                     :length => { :minimum => 5 }

  private

  def post_params
    params.require(:post).permit(:titulo, :texto)
  end
end
