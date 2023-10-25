import { writable } from "svelte/store";

export const ENTITY_INFO = writable<ENTITY_INFO[]>(null);
  
interface ENTITY_INFO {
    show: boolean;
    name: string;
    hash: string;
}