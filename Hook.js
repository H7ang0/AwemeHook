Java.perform(() => {
    console.log("Hooking 抖音（Aweme）...");

    // 1. 枚举所有 AWE 相关的类
    Java.enumerateLoadedClasses({
        onMatch: function(className) {
            if (className.includes("AWE")) {
                console.log("[Class Found] " + className);
            }
        },
        onComplete: function() {
            console.log("Class enumeration complete.");
        }
    });

    // 2. Hook Aweme 视频下载相关的类
    const AwemeClass = "com.ss.android.ugc.aweme.feed.model.Aweme";
    Java.perform(() => {
        try {
            const Aweme = Java.use(AwemeClass);

            // Hook 获取视频 URL 方法（高清无水印）
            Aweme.getVideoUrl.implementation = function () {
                const result = this.getVideoUrl();
                console.log("[Hooked] 视频 URL: " + result);
                return result;
            };

            // Hook 获取图片 URL（高清）
            Aweme.getCoverUrl.implementation = function () {
                const result = this.getCoverUrl();
                console.log("[Hooked] 图片 URL: " + result);
                return result;
            };

            console.log("Hook 成功: " + AwemeClass);
        } catch (e) {
            console.log("[Error] Hook 失败: " + e);
        }
    });

    // 3. Hook Live Photo（实况照片）
    const LivePhotoClass = "com.ss.android.ugc.aweme.live.model.LivePhoto";
    Java.perform(() => {
        try {
            const LivePhoto = Java.use(LivePhotoClass);

            // Hook 获取实况照片 URL
            LivePhoto.getLivePhotoUrl.implementation = function () {
                const result = this.getLivePhotoUrl();
                console.log("[Hooked] 实况照片 URL: " + result);
                return result;
            };

            console.log("Hook 成功: " + LivePhotoClass);
        } catch (e) {
            console.log("[Error] Hook 失败: " + e);
        }
    });

    // 4. Hook 评论区（含表情）
    const CommentClass = "com.ss.android.ugc.aweme.comment.model.Comment";
    Java.perform(() => {
        try {
            const Comment = Java.use(CommentClass);

            // Hook 获取评论文本
            Comment.getText.implementation = function () {
                const result = this.getText();
                console.log("[Hooked] 评论: " + result);
                return result;
            };

            // Hook 获取评论中的表情
            Comment.getEmoticon.implementation = function () {
                const result = this.getEmoticon();
                console.log("[Hooked] 评论区表情: " + result);
                return result;
            };

            console.log("Hook 成功: " + CommentClass);
        } catch (e) {
            console.log("[Error] Hook 失败: " + e);
        }
    });

    console.log("所有 Hook 逻辑已执行完毕");
});
