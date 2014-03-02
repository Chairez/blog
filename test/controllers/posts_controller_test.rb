require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    @post = posts(:one)
  end

  #Pruebas de creación de posts:
  test "debe crear un post" do
    get :new
    assert_response :success
  end

  test "no guardar un post si no tiene titulo" do
    post = Post.new
    assert !post.save
  end

  test "debe crear un post y redireccionar a la lista" do
    assert_difference('Post.count') do
      post :create, post: {titulo: 'El que sea', texto:"otra vez el que sea"}
    end
 
    assert_redirected_to post_path(assigns(:post))
  end

  #Pruebas para mostrar un post
  test "debe mostrar un post" do
    get :show, id: @post.id
    assert_response :success
  end
  
  #Pruebas de obtención de la página principal
  test "obtener el index" do
    get :index
    assert_response :success
  end

  #Pruebas para mostrar un post en edición
  test "debe enviar un post a edicion" do
    get :edit, id: @post.id
    assert_response :success
  end
  
  #Pruebas para editar un post 
  test "debe actualizar un post" do
    get :update, post: @post 
    assert_response :success
  end

  #Pruebas para eliminar un post
  test "debe destruir un post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
    end 
    assert_redirected_to posts_path
  end
end
