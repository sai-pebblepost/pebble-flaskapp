#!/bin/bash
service nginx status
ls
gunicorn3 app:app
