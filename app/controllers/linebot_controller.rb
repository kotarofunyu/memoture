class LinebotController < ApplicationController
  def callback
    @registration = Memos::Registration.new(body: request.body.read, signature: request.env['HTTP_X_LINE_SIGNATURE'])

    if @registration.save
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
