class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.new(comment_params)

  respond_to do |format|
    if @comment.save
      format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
      # format.json { render :show, status: :created, location: @idea }
    else
      format.html { render :new }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(idea_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_email, :body, :post_id)
    end
end
