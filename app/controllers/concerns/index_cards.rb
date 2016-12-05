module IndexCards
  def find_card
    if params[:id]
      @card = current_user.cards.find(params[:id])
    elsif current_user.current_block
      @card = current_user.current_block.cards.pending.first
      @card ||= current_user.current_block.cards.repeating.first
    else
      @card = current_user.cards.pending.first
      @card ||= current_user.cards.repeating.first
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
