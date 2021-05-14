class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    # Pour revenir au gossip sur lequel on ajoute un commentaire
    @gossip = Gossip.find(params[:gossip_id]) 
    # Pour ajouter un commentaire
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    if (current_user)
      @gossip = Gossip.find(params[:gossip_id])
      @comment=Comment.new(content: params[:content], user: current_user, gossip: @gossip)
      if @comment.save # essaie de sauvegarder en base @gossip
        redirect_to "/index"
        flash[:info] = "Comment Saved!!"
        # si ça marche, il redirige vers la page d'index du site
      else
        redirect_to "/gossips/", notice: "Erreur de sauvegarde"
        # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      end
    else
      redirect_to "/sessions/new", notice: "Log obligatoire pour créer un gossip"
    end
  end

  def update
    if current_user
      @comment = Comment.find(params[:id])
      @gossip = Gossip.find(params[:gossip_id])

      if @comment.update(content: params[:content])

        flash[:info] = "Gossip successfully modified!"
        redirect_to gossip_path(@gossip.id)
      else
        render 'edit'
      end
    else
      redirect_to "/sessions/new", notice: "Log obligatoire pour créer un gossip"
    end
  end

  def destroy
    if current_user
      @gossip = Gossip.find(params[:gossip_id])
      @comment = Comment.find(params[:id])

      @comment.destroy
      flash[:alert] = "Comment deleted!"
      redirect_to gossip_path(@gossip.id)
    else
      redirect_to "/sessions/new", notice: "Log obligatoire pour créer un gossip"
    end
  end

end