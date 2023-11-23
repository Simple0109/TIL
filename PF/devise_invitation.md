### 招待機能の実装
```ruby
# app/controllers/invitations_controller.rb

class InvitationsController < ApplicationController
  def create_invitation
    @group = Group.find(params[:group_id])
    @invitation_link = invitation_link(current_user.invitation_token, @group.id)
  end

  def accept_invitation
    @group_id = params[:group_id]
    @invitation_token = params[:invitation_token]

    if current_user.present?
      handle_registered_user
    else
      handle_unregistered_user
    end
  end

  private

  def handle_registered_user
    current_user.groups << Group.find(@group_id)
    redirect_to root_path, notice: 'You have been added to the group.'
  end

  def handle_unregistered_user
    session[:group_id] = @group_id
    redirect_to new_user_registration_path
  end

  def invitation_link(invitation_token, group_id)
    process_invitation_url(invitation_token: invitation_token, group_id: group_id)
  end
end
```
---
分解
```ruby
def create_invitation
  @group = Group.find(params[:group_id])
  @invitation_link = invitation_link(current_user.invitation_token, @group.id)
end
```
`invitation_token`
deviseが提供する招待トークン。招待者ごとに一意であり招待を一意に識別する
`@group_id`
招待されるグループのID。このIDをリンクに含めることで招待者がどのグループに他のユーザーを招待しているかを識別できる
`invitation_link`
招待リンクを生成するためのカスタムメソッド。招待者の招待トークンと、グループIDを組み合わせてリンクを生成する
