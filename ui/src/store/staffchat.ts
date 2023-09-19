import { writable } from 'svelte/store'

interface ChatData {
	message: string
	citizenid: string
	fullname: string
	time: number
}

export const Message = writable<ChatData[]>(null)
export const Messages = writable<ChatData>(null)
