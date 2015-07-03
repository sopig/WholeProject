http://segmentfault.com/a/1190000000364677

通过网络几篇文章整理的大致全面的教程。

1.安装Octopress

确保安装了git和ruby1.9.3,通过brew安装rbenv然后用rbenv安装ruby。

安装brew

先卸载MacPorts

sudo prot -f uninstall installed
sudo rm -fr \
再安装brew

curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz –strip 1 -C /usr/local

export PATH=/usr/local/bin:$PATH
安装成功后通过brew install查看brew版本

安装ruby

brew install rbenv
brew install ruby-build
rbenv install 1.9.3-p0
rbenv rehash
最后安装Octopress

git clone git://github.com/imathis/octopress.git octopress

cd octopress
gem install bundler
rbenv rehash
bundle install
rake install
配置Octopress

编辑 config.yml文件的url,title,subtitle,author。

最好把里面的twitter相关的信息全部删掉，否则由于GFW的原因，将会造成页面load很慢。同理，修改定制文件/source/_includes/custom/head.html 把google的自定义字体去掉。

安装支持新浪微博和Dribbble的Octopress的Greyshade主题

我现在用的就是greyshade主题 http://www.sgxiang.com

 cd octopress

 git clone git@github.com:allenhsu/greyshade.git .themes/greyshade

 echo "\$greyshade: color;" >> sass/custom/_colors.scss //替换 color 为自定义的链接高亮颜色

 rake "install[greyshade]"
在_config.yml中加入

weibo_user: xsxiang # 微博数字 ID 或域名 ID
dribbble_user: 
weibo_share: true # 是否开启微博分享按钮
关于greyshade主题的头像问题，有两种途径可以设置头像

在_config.yml文件中设置一个email，然后到gravatar网站上添加该email并上传一张头像
将需要使用的图片放到/source/images下。然后把/source/_includes/header.html文件中的img替换成 《img alt=“Profile Picture” src=“/images/tx.png” style=“width:160px;”》
配置Disqus插件

Disqus是octopress内置的comments功能，编辑config.yml文件可以打开该功能，找到以下内容修改

#Disqus comments
disqus_short_name: 
disqus_show_comment_count: false
填入注册disqus账号的名称，并将false修改为true。【disqus要和自己的username.github.com关联上】

2.配置github相关

在本机创建ssh

cd ~/.ssh
ssh-keygen -t rsa -C 你注册github时的email
弹出Enter file in which to save the key (/Users/twer/.ssh/id_rsa):直接按空格

弹出Enter passphrase (empty for no passphrase):输入你github账号的密码。Enter same passphrase again:再次输入你的密码。

打开~/.ssh下的id_rsa.pub文件复制里面的全部内容。
登陆github，选择Account Settings-->SSH Public Keys 添加ssh，把剪切板的内容复制到key输入框内直接保存。

测试shh:

ssh git@github.com
输出

PTY allocation request failed on channel 0
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.
代表成功

建立一个仓库

登陆github创建一个仓库 ，仓库名称为username.github.com比如我的是sgxiang.github.com

3.部署博客到github

利用octopress的一个配置rake任务来自动配置上面创建的仓库：可以让我们方便的部署GitHub page。在终端输入如下命令：

rake setup_github_pages
弹出之后输入git@github.com:your_username/your_username.github.com.git不要用提示的io，我的是git@github.com/sgxiang/sgxiang.github.com.git

输入以下命令部署博客

rake generate
rake deploy
如果无法push到仓库的master分支，尝试在项目目录的.git/config中添加

[branch "master"]
 remote = origin
 merge = refs/heads/master
博客的source需要单独提交，执行如下命令就可以将source提交到仓库的source分支下

git add .
git commit -m 'Initial source commit'
git push origin source
部署前可以在本地预览，输入rake preview之后在浏览器输入http://localhost:4000/来访问

4.写博客

通过命令

rake new_post["myTitle"]
文章生成在目录下的source/_posts目录下。文章是markdown格式的。可以通过 Mou 软件来编辑保存。

关于markdown的格式可以参考这篇文章:http://wowubuntu.com/markdown/

写完后就可以部署更新文章到github上了

rake generate
git add .
git commit -am "Some comment here." 
git push origin source
rake deploy
参考文章

http://m.blog.csdn.net/blog/duck_genuine/7736037
http://www.imallen.com/blog/2013/10/16/deploying-octopress-to-qiniu.html
http://beyondvincent.com/blog/2013/08/03/108-creating-a-github-blog-using-octopress/
http://blog.devtang.com/blog/2012/02/10/setup-blog-based-on-github/
http://www.imallen.com/blog/2013/05/12/add-support-for-weibo-and-dribbble-to-greyshade.html
http://xautjzd.github.io/blog/2013/07/18/add-navigator/
http://xautjzd.github.io/blog/2013/07/18/congfig-disqus-plugin/
http://gilguan.github.io/blog/2013/10/16/zai-macshang-shi-yong-octopressda-jian-githubbo-ke/
octopress mac github
链接 更多
分享 新浪微博微信TwitterFacebook人人网豆瓣
1 推荐   收藏
你可能感兴趣的文章

静态博客，不只有Jekyll&Octopress 831 浏览
[新姿势]我用过的静态站点生成器们 13 收藏，1.8k 浏览
hexo —— 简单、快速、强大的Node.js静态博客框架 13 收藏，8.4k 浏览
讨论区

1
添加头像“在_config.yml文件中设置一个email，然后到gravatar网站上添加该email并上传一张头像”这一步，是直接在_config.yml 中这样写“email: xxx.gmail.com”（没有双引号）这样就可以了吗？gravatar网站我注册了，也上传了头像，最后还是没有看到效果，还需要弄其他地方的吗？



 


 
回复 我_阿元：
email和地址间要空格 email应该有@的吧
还有确认下是否真的上传成功头像和你的邮箱绑定了


 
回复 Yaashion_向：
恩，谢谢，已经修改成功。绑定成功之后是有时间延迟的，后来它就自己好了。


我在搭建过程中，遇到了一个10.9以后新版本OS X带来的问题。就是bundle install，总是失败，提示mac Error installing RedCloth:，后来我参考了stackoverflow推荐的链接http://stackoverflow.com/questions/26543572/failed-to-install-redcloth-with-ruby-2-0-0p451on-mac-os-x-10-9-4-and-xcode-versi，就是要在终端输入xcode-select --install。然后才ok，希望能给遇到同样问题的人帮助

 
回复 熊熊的狮子：
想不到还有人看。。 我记得我之前也遇到过 谢谢啊~


回复 Yaashion_向：
想不到博主还在，我遇到一个上传文章的问题，最后push文章到github，git push origin source，总是失败，提示remote: Repository not found.
fatal: repository 'https://github.com/projectname/projectname.github.io/' not found。这是怎么解决啊


回复 熊熊的狮子：
rake setup_github_pages
弹出之后输入git@github.com:your_username/your_username.github.com.git不要用提示的io，我的是git@github.com/sgxiang/sgxiang.github.com.git

看下你这个配置对不对
而且你这个 https://github.com/projectname/projectname.github.io/ 我在github上找不到


