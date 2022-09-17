require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:achillas_app_qa)
  end

  test 'get index' do
    sign_in users(:achilla_marsh)

    get projects_path

    assert_response :success
  end

  test 'get new' do
    sign_in users(:achilla_marsh)

    get new_project_path

    assert_response :success
  end

  test 'post create project' do
    sign_in users(:achilla_marsh)

    assert_difference 'Project.count' do
      post projects_path, params: { project: { description: @project.description, title: @project.title } }
    end

    assert_redirected_to project_path(proj = Project.last)

    assert_includes users(:achilla_marsh).projects, proj
  end

  test 'get show' do
    sign_in users(:achilla_marsh)

    get project_path(@project)

    assert_response :success
  end

  test 'get show unauth user' do
    sign_in users(:bodo_bolger)

    get project_path(@project)

    assert_response :not_found
  end

  test 'get edit' do
    sign_in users(:achilla_marsh)

    get edit_project_path(@project)

    assert_response :success
  end

  test 'patch update' do
    sign_in users(:achilla_marsh)

    patch project_path(@project), params: {
      project: { description: @project.description, title: @project.title } }

    assert_redirected_to project_path(@project)
  end

  test 'delete destroy' do
    sign_in users(:achilla_marsh)

    assert_difference 'Project.count', -1 do
      delete project_path(@project)
    end

    assert_redirected_to projects_path
  end
end
