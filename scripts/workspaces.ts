#! /bin/bun

import { $ } from 'bnx'

const workspaceMap = {
    1: [1, 2, 3, 4],
    2: [5, 6, 7, 8],
    3: [9, 10, 11, 12],
    4: [13, 14, 15, 16],
}

const args = new Set(process.argv.splice(2))
// console.log('args:', args)
const goNext = args.has('next')
// console.log('goNext?', goNext)
const bring = args.has('bring')
// console.log('bring?', bring)

const allWorkspaces = JSON.parse($`swaymsg -t get_workspaces`)
const currentWorkspace = allWorkspaces.filter(workspace => workspace.focused)
const current = currentWorkspace[0].num
// console.log('current workspace:', current)


const target = goNext ? (current + 4) : (current - 4)
// console.log('target', target)
if (target < 1 || target > 16) process.exit()


const allRelatives = new Set(workspaceMap[Math.ceil(target / 4)])
allRelatives.delete(target)
const targetRelatives = [...allRelatives, target]
// console.log('targetRelatives', targetRelatives)

if (bring) {
    // console.log(`move container to workspace ${target}`)
    $`swaymsg move container to workspace ${target}`
}

targetRelatives.forEach(targetRelative => {
    // console.log(`go to workspace ${targetRelative}`)
    $`swaymsg workspace ${targetRelative}`
})
