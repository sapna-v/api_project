class TagsController < ApplicationController
  def index
    render json: Tag.public_fields.all
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      response = { message: 'Tag created successfully' }
      render json: response, status: :created
    else
      render json: @tag.errors, status: 400
    end
  end

  def edit
    if params[:old_tag].present? && params[:new_tag].present?
      update
    else
      render json: { message: 'Unprocessable entity.' }, status: 422
    end
  end

  def update
    @tag = Tag.find_by(name: params[:old_tag])
    if @tag.present?
      if @tag.update(name: params[:new_tag])
        render json: { message: 'Tag updated successfuly.' }, status: 200
      else
        render json: @tag.errors, status: 400
      end
    else
      render json: { message: 'No such tag found.' }, status: 404
    end
  end

  def delete
    if params[:name].present?
      @tag = Tag.find_by(name: params[:name])
      if @tag.present?
        if @tag.delete
          render json: { message: 'Successfully deleted.' }, status: 200
        else
          render json: @tag.errors, status: 400
        end
      else
        render json: { message: 'No such tag found.' }, status: 400
      end
    else
      render json: { message: 'Unprocessable entity.' }, status: 422
    end
  end

  def sort_tags
    if params[:sort_by].present?
      if Tag.valid_field?(params[:sort_by])
        render json: Tag.public_fields.order(params[:sort_by]), status: 200
      else
        render json: { message: 'Invalid sort parameter.' }, status: 400
      end
    else
      render json: { message: 'Unprocessable entity.' }, status: 422
    end
  end

  private

  def tag_params
    params.permit(:name)
  end
end