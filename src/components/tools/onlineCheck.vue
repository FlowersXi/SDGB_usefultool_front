<script setup>
import { onMounted, ref } from 'vue'
import { useI18n } from 'vue-i18n'
import { API_BASE_URL } from '../../config.js'

const { t } = useI18n()

// 三态：null 表示请求中
const serverStatus = ref({
  aimedb: null,
  allnet: null,
  titleserver: null,
  updateserver: null
})

// 请求服务器状态函数
async function fetchServerStatus() {
  try {
    const res = await fetch(`${API_BASE_URL}/api/v1/serverstatus`)
    const data = await res.json()
    
    if (res.ok && data.stat === 1) {
      serverStatus.value = data.data
    } else {
      alert(data.msg || '请求服务器状态失败')
      Object.keys(serverStatus.value).forEach(key => serverStatus.value[key] = false)
    }
  } catch (error) {
    alert('请求服务器状态失败: ' + error.message)
    Object.keys(serverStatus.value).forEach(key => serverStatus.value[key] = false)
  }
}

// 页面加载时调用
onMounted(() => {
  fetchServerStatus()
})

// 工具函数：根据状态返回图片路径
const getStatusImg = (status) => status ? '/img/gameasset/Network/On.png' : '/img/gameasset/Network/Off.png'
</script>

<template>
  <div class="p_15">
    <div class="town_block m_t_10 m_b_20 p_10 p_b_0 f_14 t_l black">
      <table class="m_t_10">
        <tr>
          <td class="t_c h_40">服务器在线状态</td>
        </tr>
        <tr>
          <td colspan="2"><img src="/img/line_01.png" class="w_430" /></td>
        </tr>
        <tr>
          <td>AimeDB (WeChat Aime)</td>
          <td class="t_r h_40" v-if="serverStatus.aimedb === null">请求中……</td>
            <td class="t_r f_0" v-else>
              <img :src="getStatusImg(serverStatus.aimedb)" class="h_40" />
            </td>
        </tr>
        <tr>
          <td colspan="2"><img src="/img/line_01.png" class="w_430" /></td>
        </tr>
        <tr>
          <td>All.net</td>
          <td class="t_r h_40" v-if="serverStatus.allnet === null">请求中……</td>
            <td class="t_r f_0" v-else>
              <img :src="getStatusImg(serverStatus.allnet)" class="h_40" />
            </td>
        </tr>
        <tr>
          <td colspan="2"><img src="/img/line_01.png" class="w_430" /></td>
        </tr>
        <tr>
          <td>标题服务器</td>
          <td class="t_r h_40" v-if="serverStatus.titleserver === null">请求中……</td>
            <td class="t_r f_0" v-else>
              <img :src="getStatusImg(serverStatus.titleserver)" class="h_40" />
            </td>
        </tr>
        <tr>
          <td colspan="2"><img src="/img/line_01.png" class="w_430" /></td>
        </tr>
        <tr>
          <td>更新服务器</td>
            <td class="t_r h_40" v-if="serverStatus.updateserver === null">请求中……</td>
            <td class="t_r f_0" v-else>
              <img :src="getStatusImg(serverStatus.updateserver)" class="h_40" />
            </td>
        </tr>
      </table>
    </div>
    <img src="/img/line_02.png" class="w_450" />
    <div class="t_c">
        <button type="button" onclick="history.back();" class="f_0">
            <img src="/img/btn_back.png" class="w_80 m_t_10" />
        </button>
    </div>
  </div>
</template>

<style scoped></style>
