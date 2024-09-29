# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: @comment.model_name.human)
    else
      render_commentable_show
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: @comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: @comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def render_commentable_show
    case @commentable
    when Book
      @book = @commentable
      render 'books/show'
    when Report
      @report = @commentable
      render 'reports/show'
    end
  end
end
