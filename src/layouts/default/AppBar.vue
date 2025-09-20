<template>
    <div class="wrapper t_c">
        <a href="/"><img src="/img/logo.png" class="logo p_5" /></a>
        <a href="/tools/onlineCheck/" class="network"><img :src="networkSrc" /></a>
    </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue'
import { API_BASE_URL } from '../../config.js'  // 根据项目路径修改
const onlineStatus = ref(true);
const networkSrc = computed(() => {
    return onlineStatus.value
        ? '/img/gameasset/Network/On.png'
        : '/img/gameasset/Network/Off.png'
})
const getOnlineStatus = async () => {
    try {
        const url = `${API_BASE_URL}/api/v1/ping`

        const response = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        })
        const result = await response.json()

        if (result.stat === 1 && result.data === "pong") {
            onlineStatus.value = true;
        } else {
            onlineStatus.value = false;
        }
    } catch (error) {
        onlineStatus.value = false;
    } finally {
    }
}
onMounted(() => {
    // console.log('AppBar mounted');
    getOnlineStatus();
})
</script>
