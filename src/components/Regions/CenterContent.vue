<template>
    <div :class="['regions', regionClass]" @click.self.prevent="onBlur">
        <header
            :class="{
                padded: isPadded('header'),
                'has-bar': headerBar,
                'has-seperator': headerSeperator,
            }"
            @click.self.prevent="onBlur"
        >
            <div
                v-if="$slots.header"
                class="inner"
                @click.self.prevent="onBlur"
            >
                <slot name="header" />
            </div>
        </header>

        <main
            :class="{ padded: isPadded('content') }"
            @click.self.prevent="onBlur"
        >
            <div
                v-if="$slots.content"
                class="inner"
                @click.self.prevent="onBlur"
            >
                <slot name="content" />
            </div>
        </main>

        <footer
            :class="{ padded: isPadded('footer') }"
            @click.self.prevent="onBlur"
        >
            <div
                v-if="$slots.footer"
                class="inner"
                @click.self.prevent="onBlur"
            >
                <slot name="footer" />
            </div>
        </footer>
    </div>
</template>

<script>
import { computed } from "vue"

export default {
    name: "Regions:CenterContent",
    props: {
        padded: {
            type: Array,
            default: () => [],
        },
        regionName: {
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
    emits: ["blur"],
    setup: function(props, { emit }) {
        const regionClass = computed(() => {
            if (props.regionName) return `region-${props.regionName}`

            return undefined
        })

        const isPadded = region => props.padded.includes(region)

        const onBlur = () => {
            emit("blur")
        }

        return { regionClass, isPadded, onBlur }
    },
}
</script>

<style scoped lang="scss">
@import "@/assets/css/_variables.scss";

.regions {
    width: 100%;
    display: grid;
    grid-template-columns: 100%;
    grid-template-rows: auto 1fr auto;
    min-height: 100%;
    /* min-height: stretch; */

    > * {
        width: 100%;
    }
}

.padded {
    > .inner {
        max-width: $layout-default-maxWidth;
        padding-left: $layout-default-sideGap;
        padding-right: $layout-default-sideGap;
        box-sizing: content-box;

        margin: 0 auto;
    }
}

header {
    &.has-bar {
        border-bottom: 1px solid var(--color_3);
    }
    &.has-seperator {
        margin-bottom: $layout-default-sideGap;
    }
}
</style>
