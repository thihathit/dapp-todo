<template>
    <div :class="['layouts layout-center-content', pageClass]">
        <div id="top">
            <header
                v-if="$slots.header"
                id="header"
                :class="{
                    padded: isPadded('header'),
                    'has-bar': headerBar,
                    'has-seperator': headerSeperator,
                }"
            >
                <div class="inner">
                    <slot name="header" />
                </div>
            </header>

            <section
                v-if="$slots.info"
                id="info"
                :class="{ padded: isPadded('info') }"
            >
                <div class="inner">
                    <slot name="info" />
                </div>
            </section>
        </div>

        <main id="middle">
            <section
                v-if="$slots.highlight"
                id="highlight"
                :class="{ padded: isPadded('highlight') }"
            >
                <div class="inner">
                    <slot name="highlight" />
                </div>
            </section>

            <section
                v-if="$slots.content || $slots.default"
                id="content"
                class="padded"
            >
                <div class="inner">
                    <slot name="content" />
                    <slot />
                </div>
            </section>

            <section
                v-if="$slots.lowlight"
                id="lowlight"
                :class="{ padded: isPadded('lowlight') }"
            >
                <div class="inner">
                    <slot name="lowlight" />
                </div>
            </section>
        </main>

        <div id="bottom">
            <section
                v-if="$slots['pre-footer']"
                id="pre-footer"
                :class="{ padded: isPadded('pre-footer') }"
            >
                <div class="inner">
                    <slot name="pre-footer" />
                </div>
            </section>

            <footer
                v-if="$slots.footer"
                id="footer"
                :class="{ padded: isPadded('footer') }"
            >
                <div class="inner">
                    <slot name="footer" />
                </div>
            </footer>
        </div>
    </div>
</template>

<script>
import { computed } from "vue"

export default {
    name: "CenterContent",
    props: {
        padded: {
            type: Array,
            default: () => [],
        },
        pageName: {
            type: String,
        },
        headerBar: {
            type: Boolean,
            default: false,
        },
        headerSeperator: {
            type: Boolean,
            default: false,
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
    display: flex;
    min-height: stretch;
}

main {
    display: flex;
    align-items: center;

    > * {
        width: 100%;
    }
}

.layouts {
    width: 100%;
    display: grid;
    grid-template-columns: 100%;
    grid-template-rows: auto 1fr auto;
    min-height: 100%;
    /* min-height: stretch; */
}
.layouts > * {
    width: 100%;
}

.padded {
    > .inner {
        max-width: $layout-centerContent-maxWidth;
        padding-left: $layout-centerContent-sideGap;
        padding-right: $layout-centerContent-sideGap;
        box-sizing: content-box;

        margin: 0 auto;
    }
}

header {
    &.has-bar {
        border-bottom: 1px solid var(--color_3);
    }
    &.has-seperator {
        margin-bottom: $layout-centerContent-sideGap;
    }
}
</style>
