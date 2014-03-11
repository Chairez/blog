# encoding: UTF-8
require 'simplecov'
SimpleCov.start
require 'test_helper'

# Clase de pruebas de unidad: Comments
class CommentsControllerTest < ActionController::TestCase
 def setup
    @post = posts(:one)
  end
  test "the truth" do
    assert true   
  end
  # Pruebas de creacion de comentario:
  #test 'debe crear un comentario' do
   # get :new
    #assert_response :success
  #end

  test 'no guardar un comentario si no tiene texto' do
    post = Post.new
    assert !post.save
  end

  # Pruebas para eliminar un comentario
  #test 'debe destruir un comentario' do
   # assert_difference('Post.count', -1) do
    #  delete :destroy, id: @post.id
    #end
  #end
end
