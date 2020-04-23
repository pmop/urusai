defmodule UrusaiWeb.PostLive.PostComponent do
    use UrusaiWeb, :live_component

    def render(assigns) do
        ~L"""
        <div class="post-container">
            <div id="post-<%= @post.id %>" class="post">
                    <div class="row">
                        <div class="column column-10">
                            <div class="post-avatar"> </div>
                            <div class="username">
                                <b>@<%= @post.username %></b>
                            </div>
                        </div>
                        <div class="column column-10">
                        </div>
                        <div class="column column-90">
                            <%= @post.body %>
                        </div>
                    </div>
                <div class="row">
                    <div class="column">
                    <a href="#" phx-click="like" phx-target="<%= @myself %>">
                        <i class="fa fa-heart"></i> <%= @post.likes_count %>
                    </a>
                    <a href="#" phx-click="repost" phx-target="<%= @myself %>">
                        <i class="fa fa-retweet"></i> <%= @post.reposts_count %>
                    </a>
                    </div>
                    <div class="column">
                        <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
                            <i class="fa fa-edit"></i>
                        <% end %>
                        <%= live_patch to: "#", phx_click: "delete", phx_value_id: @post.id do %>
                            <i class="fa fa-trash-alt"></i>
                        <% end %>
                    </div>
                </div>
            </div>
        </div>
        """
    end

    def handle_event("like", _, socket) do
        Urusai.Timeline.inc_likes(socket.assigns.post)
        {:noreply, socket}
    end

    def handle_event("repost", _, socket) do
        Urusai.Timeline.inc_reposts(socket.assigns.post)
        {:noreply, socket}
    end
end