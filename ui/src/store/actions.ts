import { writable } from "svelte/store";

export const ALL_ACTIONS = writable<boolean>(true);

export const ACTION = writable<any[]>(null);
  
interface DROPDOWN_DATA {
    label: string;
    type: string;
    option?: string;
    data?: any[];
    event?: string;
}
  
interface ACITONS_DATA {
    id: string;
    label: string;
    type?: string;
    event?: string;
    perms: string[];
    dropdown?: DROPDOWN_DATA[];
}