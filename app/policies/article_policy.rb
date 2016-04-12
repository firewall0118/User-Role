class ArticlePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @article = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @current_user.admin? or @current_user.editor?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    @current_user.admin? or (@current_user.editor? && @article.user == @current_user)
  end

  def destroy?
    @current_user.admin? or (@current_user.editor? && @article.user == @current_user)
  end

end
