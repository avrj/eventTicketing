# coding: utf-8
class SeatsController < ApplicationController
  def index
    @seats = Seat.all.order(table: :asc, seat: :asc)
  end
end
