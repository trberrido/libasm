# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thberrid <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/01 22:59:58 by thberrid          #+#    #+#              #
#    Updated: 2021/02/24 10:57:17 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL	= /bin/sh

NAME	= libasm.a

AR 	= ar rc
CC	= gcc

DIR_S 	= sources
DIR_O	= obj
DIR_H	= includes
NAME_S	= 	ft_strlen.s \
			ft_strcpy.s \
			ft_strcmp.s \
			ft_write.s	\
			ft_read.s 	\
			ft_strdup.s
NAME_O	= $(NAME_S:.s=.o)
NAME_H	= libasm.h
FILES_S	= $(addprefix $(DIR_S)/, $(NAME_S))
FILES_O	= $(addprefix $(DIR_O)/, $(NAME_O))
FILES_H	= $(addprefix $(DIR_H)/, $(NAME_H))

FLAGS_NASM	= -f elf64
FLAGS_LD	= -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc
FLAGS_CC	= -Wall -Wextra -Werror

.PHONY: all
all : $(NAME)

$(NAME) : $(FILES_O)
	$(AR) $@ $^
	ranlib $@
 
$(DIR_O)/%.o: $(DIR_S)/%.s $(FILES_H)
	@ mkdir -p $(DIR_O)
	nasm $(FLAGS_NASM) -o $@ $<

test : $(NAME) main.c
	$(CC) $(FLAGS_CC) main.c -I ./$(DIR_H) -L . -lasm -o test

.PHONY : clean
clean :
	rm -f $(FILES_O)

.PHONY : fclean
fclean : clean
	rm -f $(NAME)
	rm -f test

.PHONY : re
re : fclean all
