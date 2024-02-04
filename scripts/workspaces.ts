#! /bin/bun

import { $ as cmd } from 'bnx'
const filled = ' '
const hollow = ' '
// const hollow = ' '

const workspaceMap = {
    1: [1, 2, 3, 4],
    2: [5, 6, 7, 8],
    3: [9, 10, 11, 12],
    4: [13, 14, 15, 16],
}

const workspaceStatusMap = {
    1: `${filled}${hollow}${hollow}${hollow}`,
    2: `${hollow}${filled}${hollow}${hollow}`,
    3: `${hollow}${hollow}${filled}${hollow}`,
    4: `${hollow}${hollow}${hollow}${filled}`,
}

const args = new Set(process.argv.splice(2))
// console.log('args:', args)
const goNext = args.has('next')
// console.log('goNext?', goNext)
const bring = args.has('bring')
// console.log('bring?', bring)

const allWorkspaces = JSON.parse(await cmd`swaymsg -t get_workspaces`)
const currentWorkspace = allWorkspaces.filter(workspace => workspace.focused)
const current = currentWorkspace[0].num
// console.log('current workspace:', current)

if (args.has('status')) {
    console.log(workspaceStatusMap[Math.ceil(current / 4)])
    process.exit()
}

const target = goNext ? (current + 4) : (current - 4)
// console.log('target', target)
if (target < 1 || target > 16) process.exit()


const allRelatives = new Set(workspaceMap[Math.ceil(target / 4)])
allRelatives.delete(target)
const targetRelatives = [...allRelatives, target]
// console.log('targetRelatives', targetRelatives)

let command = ""

if (bring) {
    // console.log(`move container to workspace ${target}`)
    await cmd("swaymsg move container to workspace " + target)
}

for (const targetRelative of targetRelatives) {
    await cmd("swaymsg workspace " + targetRelative)

}
targetRelatives.forEach(targetRelative => {
    // console.log(`go to workspace ${targetRelative}`)
})

await cmd`pkill -SIGRTMIN+8 waybar`
