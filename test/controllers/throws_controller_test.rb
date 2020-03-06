require 'test_helper'

class ThrowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @throw = throws(:one)
  end

  test "should get index" do
    get throws_url, as: :json
    assert_response :success
  end

  test "should create throw" do
    assert_difference('Throw.count') do
      post throws_url, params: { throw: { bonus1: @throw.bonus1, bonus2: @throw.bonus2, frameId: @throw.frameId, frame_score: @throw.frame_score, game_id: @throw.game_id, pins: @throw.pins, special_calls: @throw.special_calls, throwId: @throw.throwId } }, as: :json
    end

    assert_response 201
  end

  test "should show throw" do
    get throw_url(@throw), as: :json
    assert_response :success
  end

  test "should update throw" do
    patch throw_url(@throw), params: { throw: { bonus1: @throw.bonus1, bonus2: @throw.bonus2, frameId: @throw.frameId, frame_score: @throw.frame_score, game_id: @throw.game_id, pins: @throw.pins, special_calls: @throw.special_calls, throwId: @throw.throwId } }, as: :json
    assert_response 200
  end

  test "should destroy throw" do
    assert_difference('Throw.count', -1) do
      delete throw_url(@throw), as: :json
    end

    assert_response 204
  end
end
