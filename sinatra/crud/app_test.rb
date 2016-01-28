#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information
#---
require_relative 'app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'Bookmarking App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'returns a list of bookmarks' do
    get '/bookmarks'
    expect(last_response).to be_ok
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks).to be_instance_of(Array)
  end

  it 'creates a new bookmark' do
    get '/bookmarks'
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size # (1)

    post('/bookmarks', url: 'http://www.test.com', title: 'Test')

    expect(last_response.status).to eq(201)
    expect(last_response.body).to match(%r{\/bookmarks\/\d+}) # (2)

    get '/bookmarks'
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size + 1) # (3)
  end

  it 'updates a bookmark' do
    post('/bookmarks', url: 'http://www.test.com', title: 'Test')
    bookmark_uri = last_response.body
    id = bookmark_uri.split('/').last # (4)

    put("/bookmarks/#{id}", title: 'Success') # (5)
    expect(last_response.status).to eq(204)

    get "/bookmarks/#{id}"
    retrieved_bookmark = JSON.parse(last_response.body)
    expect(retrieved_bookmark['title']).to eq('Success') # (6)
  end

  it 'deletes a bookmark' do
    post('/bookmarks', url: 'http://www.test.com', title: 'Test')
    get '/bookmarks'
    # puts last_response.body
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size

    delete("/bookmarks/#{bookmarks.last['id']}")
    expect(last_response.status).to eq(200)

    get('/bookmarks')
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size - 1)
  end
end
