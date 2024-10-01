#!/bin/bash
set -eu


# * ComfyUI: 主程序
# * ComfyUI-Crystools: 资源监控器、进度条和已用时间、元数据以及在两个图像之间进行比较
#   ComfyUI_essentials: 不在 ComfyUI 中核心节点中的基础节点
#   ComfyUI_FaceAnalysis: 该扩展使用DLib或InsightFace对人脸执行各种操作，如计算两张脸之间的相似度。
#   ComfyUI_InstantID:  从单个参考 ID 图像生成具有各种姿势或风格的定制图像，同时确保高保真度。
# * comfyui_controlnet_aux: 各种预处理器：深度图、姿势估计、线稿
# * ComfyUI-Frame-Interpolation: 用于视频帧插值、视频补针。
#   ComfyUI_FizzNodes:  用于动画制作中的基于时间的提示词、浮点数规划、音画同步？
#   efficiency-nodes-comfyui: ComfyUI自定义节点的集合，有助于简化工作流程并减少节点总数。
# * ComfyUI-KJNodes: 实用节点，如获取图像尺寸、设置整形、浮点、字符串等常量、类型处理等
# * ComfyUI-VideoHelperSuite: 将视频转为一系列图像、将一组图像转为视频
# * ComfyUI-Impact-Pack: 物体检测SAM与遮罩生成
#   ComfyUI-Impact-Subpack: 物体检测SAM与遮罩生成附加
#   ComfyUI-Inspire-Pack: 对 Impact-Pack 进行精简，并提供差异化的功能
# * ComfyUI-Manager: 提供了安装、删除、禁用和启用ComfyUI 各种自定义节点的管理功能。
#   comfy_mtb: 换脸、视频补针、图片合成视频
#   comfyui_segment_anything: 物体检测SAM与遮罩生成
#   ComfyUI-InstantID: 从单个参考 ID 图像生成具有各种姿势或风格的定制图像，同时确保高保真度。
#
# * ComfyUI_LayerStyle: PhotoShop 图层样式
# * ComfyUI-MimicMotionWrapper: pose 2 video
# * Comfy-RVC: 换声
# * ComfyUI-Kolors-MZ: 适合用于重绘的扩散模型
# * ComfyUI-Deploy: 离线批量运行
# * ComfyUI-MultiGPU: 多GPU运行


array=(
https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt
https://raw.githubusercontent.com/crystian/ComfyUI-Crystools/main/requirements.txt
https://raw.githubusercontent.com/cubiq/ComfyUI_essentials/main/requirements.txt
https://raw.githubusercontent.com/cubiq/ComfyUI_FaceAnalysis/main/requirements.txt
https://raw.githubusercontent.com/cubiq/ComfyUI_InstantID/main/requirements.txt
https://raw.githubusercontent.com/Fannovel16/comfyui_controlnet_aux/main/requirements.txt
https://raw.githubusercontent.com/Fannovel16/ComfyUI-Frame-Interpolation/main/requirements-no-cupy.txt
https://raw.githubusercontent.com/FizzleDorf/ComfyUI_FizzNodes/main/requirements.txt
https://raw.githubusercontent.com/jags111/efficiency-nodes-comfyui/main/requirements.txt
https://raw.githubusercontent.com/kijai/ComfyUI-KJNodes/main/requirements.txt
https://raw.githubusercontent.com/Kosinkadink/ComfyUI-VideoHelperSuite/main/requirements.txt
https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Pack/Main/requirements.txt
https://raw.githubusercontent.com/ltdrdata/ComfyUI-Impact-Subpack/main/requirements.txt
https://raw.githubusercontent.com/ltdrdata/ComfyUI-Inspire-Pack/main/requirements.txt
https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/requirements.txt
https://raw.githubusercontent.com/melMass/comfy_mtb/main/requirements.txt
https://raw.githubusercontent.com/storyicon/comfyui_segment_anything/main/requirements.txt
https://raw.githubusercontent.com/ZHO-ZHO-ZHO/ComfyUI-InstantID/main/requirements.txt
https://raw.githubusercontent.com/chflame163/ComfyUI_LayerStyle/main/requirements.txt
https://raw.githubusercontent.com/kijai/ComfyUI-MimicMotionWrapper/main/requirements.txt
https://raw.githubusercontent.com/SayanoAI/Comfy-RVC/main/requirements.txt
https://raw.githubusercontent.com/MinusZoneAI/ComfyUI-Kolors-MZ/main/requirements.txt
https://raw.githubusercontent.com/BennyKok/comfyui-deploy/main/requirements.txt
https://raw.githubusercontent.com/neuratech-ai/ComfyUI-MultiGPU/main/requirements.txt
)

for line in "${array[@]}";
    do curl -w "\n" "${line}" >> pak5.txt
done

sed -i '/^#/d' pak5.txt
sed -i 's/[[:space:]]*$//' pak5.txt
sed -i 's/>=.*$//' pak5.txt
sed -i 's/_/-/g' pak5.txt

# Don't "sort foo.txt >foo.txt". See: https://stackoverflow.com/a/29244408
sort -ufo pak5.txt pak5.txt

echo "<pak5.txt> generated. Check before use."
