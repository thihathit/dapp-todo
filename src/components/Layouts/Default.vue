<template>
    <div :class="['layouts layout-default', pageClass]">
        <header
            v-if="$slots.header"
            id="header"
            :class="{ padded: isPadded('header') }"
        >
            <slot name="header" />
        </header>

        <section
            v-if="$slots.highlight"
            id="highlight"
            :class="{ padded: isPadded('highlight') }"
        >
            <slot name="highlight" />
        </section>

        <main
            v-if="$slots.content || $slots.default"
            id="content"
            class="padded"
        >
            <slot name="content" />
            <slot />
        </main>

        <section
            v-if="$slots.lowlight"
            id="lowlight"
            :class="{ padded: isPadded('lowlight') }"
        >
            <slot name="lowlight" />
        </section>

        <footer
            v-if="$slots.footer"
            id="footer"
            :class="{ padded: isPadded('footer') }"
        >
            <slot name="footer" />
        </footer>
    </div>
</template>

<script>
import { computed } from "vue"

export default {
    name: "Default",
    props: {
        padded: {
            type: Array,
            default: () => [],
        },
        pageName: {
            type: String,
        },
    },
    setup(props) {
        const isPadded = region => props.padded.includes(region)

        const pageClass = computed(() => {
            if (props.pageName) return `page-${props.pageName}`

            return undefined
        })

        return {
            isPadded,
            pageClass,
        }
    },
}
</script>

<style scoped lang="scss">
@import "@/assets/css/_variables.scss";

:global(body) {
    overflow-y: auto;
    overflow-x: hidden;
}
:global(#app) {
    min-height: 100%;
    min-height: stretch;
    display: flex;
}

.layouts {
    width: 100%;
    display: flex;
    flex: 1;
    flex-direction: column;
    min-height: 100%;
    min-height: stretch;
}
.layouts > * {
    width: 100%;
}

main {
    max-width: $layout-default-maxWidth;
    padding-left: $layout-default-sideGap;
    padding-right: $layout-default-sideGap;
    box-sizing: content-box;

    margin: 0 auto;
}

footer {
    margin-top: auto;
}
</style>
